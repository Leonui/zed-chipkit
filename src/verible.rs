use zed_extension_api::{self as zed, DownloadedFileType, GithubReleaseAsset, Os, Architecture};

const VERIBLE_REPO: &str = "chipsalliance/verible";
const VERIBLE_TAG: &str = "v0.0-4051-g9fdb4057";

pub struct Verible {
    cached_binary_path: Option<String>,
}

impl Verible {
    pub fn new() -> Self {
        Self {
            cached_binary_path: None,
        }
    }

    pub fn get_binary(
        &mut self,
        language_server_id: &zed::LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<String, String> {
        // 1. Return cached path if we have one
        if let Some(path) = &self.cached_binary_path {
            return Ok(path.clone());
        }

        // 2. Check PATH
        if let Some(path) = worktree.which("verible-verilog-ls") {
            self.cached_binary_path = Some(path.clone());
            return Ok(path);
        }

        // 3. Download from GitHub
        let path = self.download(language_server_id)?;
        self.cached_binary_path = Some(path.clone());
        Ok(path)
    }

    fn download(
        &self,
        language_server_id: &zed::LanguageServerId,
    ) -> Result<String, String> {
        zed::set_language_server_installation_status(
            language_server_id,
            &zed::LanguageServerInstallationStatus::CheckingForUpdate,
        );

        let release = zed::github_release_by_tag_name(VERIBLE_REPO, VERIBLE_TAG)?;
        let asset = self.platform_asset(&release.assets)?;

        let download_dir = "verible";
        let file_type = if asset.name.ends_with(".zip") {
            DownloadedFileType::Zip
        } else {
            DownloadedFileType::GzipTar
        };

        zed::set_language_server_installation_status(
            language_server_id,
            &zed::LanguageServerInstallationStatus::Downloading,
        );

        zed::download_file(&asset.download_url, download_dir, file_type)?;

        let binary_path = format!(
            "{}/verible-{}/bin/verible-verilog-ls",
            download_dir, VERIBLE_TAG
        );

        zed::make_file_executable(&binary_path)?;

        zed::set_language_server_installation_status(
            language_server_id,
            &zed::LanguageServerInstallationStatus::None,
        );

        Ok(binary_path)
    }

    fn platform_asset<'a>(
        &self,
        assets: &'a [GithubReleaseAsset],
    ) -> Result<&'a GithubReleaseAsset, String> {
        let (os, arch) = zed::current_platform();

        let suffix = match (os, arch) {
            (Os::Linux, Architecture::X8664) => "linux-static-x86_64.tar.gz",
            (Os::Linux, Architecture::Aarch64) => "linux-static-arm64.tar.gz",
            (Os::Mac, _) => "macOS.tar.gz",
            (Os::Windows, _) => "win64.zip",
            _ => return Err("Verible: unsupported platform".into()),
        };

        assets
            .iter()
            .find(|a| a.name.ends_with(suffix))
            .ok_or_else(|| format!("Verible: no asset found matching *{suffix}"))
    }
}
