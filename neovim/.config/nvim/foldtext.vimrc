"TODO: cleanup this function!
function! Minimal_foldtext()
	let lines_count = v:foldend - v:foldstart + 1
	let lines_count_text = '+' . v:folddashes . '| ' . printf("%10S" , lines_count) . ' lines |'
	let line_level_text = '| ' . printf("%8S" , 'level ' . v:foldlevel) . ' |'
	let fold_text_end = line_level_text . repeat('-',8)
	let fold_text_length = strlen(lines_count_text . fold_text_end) + &foldcolumn
	return lines_count_text . repeat('-' , winwidth(0) - fold_text_length - 4) . fold_text_end
endfunction
