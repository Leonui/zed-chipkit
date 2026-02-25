use zed_extension_api::{self as zed, Command, LanguageServerId, Result, Worktree};

struct ChipKitExtension;

impl zed::Extension for ChipKitExtension {
    fn new() -> Self {
        Self
    }

    fn language_server_command(
        &mut self,
        language_server_id: &LanguageServerId,
        worktree: &Worktree,
    ) -> Result<Command> {
        match language_server_id.as_ref() {
            "tclsp" => self.tclsp_command(worktree),
            id => Err(format!("Unknown language server: {id}")),
        }
    }
}

impl ChipKitExtension {
    fn tclsp_command(&self, worktree: &Worktree) -> Result<Command> {
        let binary = worktree.which("tclsp").ok_or_else(|| {
            "tclsp not found in PATH. Install it with: pip install tclint".to_string()
        })?;

        Ok(Command {
            command: binary,
            args: vec![],
            env: worktree.shell_env(),
        })
    }
}

zed::register_extension!(ChipKitExtension);
