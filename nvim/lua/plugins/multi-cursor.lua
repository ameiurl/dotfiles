return {
	"mg979/vim-visual-multi",
	init = function()
		vim.cmd([[
            " let g:VM_leader                     = {'default': ',', 'visual': ',', 'buffer': ','}
            let g:VM_maps                       = {}
            let g:VM_custom_motions             = {'h': 'l', 'l': 'h'}
            let g:VM_maps['i']                  = 'i'
            let g:VM_maps['I']                  = 'I'
            let g:VM_maps['Find Under']         = '<C-m>'
            let g:VM_maps['Find Subword Under'] = '<C-m>'
            let g:VM_maps['Find Next']          = ''
            let g:VM_maps['Find Prev']          = ''
            let g:VM_maps['Remove Region']      = 'q'
            let g:VM_maps['Skip Region']        = '<c-n>'
            let g:VM_maps["Undo"]               = 'l'
            let g:VM_maps["Redo"]               = '<C-r>'
            " noremap <leader>sa <Plug>(VM-Select-All)
        ]])
	end
}
