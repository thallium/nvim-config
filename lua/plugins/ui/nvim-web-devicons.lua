return {
    'kyazdani42/nvim-web-devicons',
    opt = {
        override = {
            zsh = {
                icon = "",
                color = "#428850",
                name = "Zsh"
            }
        };
        -- globally enable default icons (default to false)
        -- will get overriden by `get_icons` option
        default = true;
    }
}
