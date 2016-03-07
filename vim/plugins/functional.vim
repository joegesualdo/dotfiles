" Unfortunately Vim doesn’t have any immutable collections like Clojure’s
"   vectors and maps built-in, but by creating some helper functions we
"   can fake it to some degree.

" NOTE: You might be thinking that copying lists all over the place is 
" wasteful, since Vim has to constantly create new copies and garbage 
" collect old ones. If so: you’re right! Vim’s lists don’t support the 
" same kind of structural sharing as Clojure’s vectors, so all those copy 
" operations can be expensive. Sometimes this will matter. If you’re
" working with enormous lists, things can slow down. In real life, though,
" you might be surprised at how little you’ll actually notice the difference.
"============

function! Sorted(l)
  let new_list = deepcopy(a:l)
  call sort(new_list)
  return new_list
endfunction

" Reversed() takes a list and returns a new list with the elements reversed.
function! Reversed(l)
  let new_list = deepcopy(a:l)
  call reverse(new_list)
  return new_list
endfunction

" Append() returns a new list with the given value appended to the end of the old one.
function! Append(l, val)
  let new_list = deepcopy(a:l)
  call add(new_list, a:val)
  return new_list
endfunction

" Assoc() (short for “associate”) returns a new list, with the element at the given index replaced by the new value.
function! Assoc(l, i, val)
  let new_list = deepcopy(a:l)
  let new_list[a:i] = a:val
  return new_list
endfunction

" Pop() returns a new list with the element at the given index removed.
function! Pop(l, i)
  let new_list = deepcopy(a:l)
  call remove(new_list, a:i)
  return new_list
endfunction

"======
" example:
" :let mylist = [[1, 2], [3, 4]]
" :echo Mapped(function("Reversed"), mylist)
function! Mapped(fn, l)
  let new_list = deepcopy(a:l)
  call map(new_list, string(a:fn) . '(v:val)')
  return new_list
endfunction

" example:
"  :let mylist = [[1, 2], [], ['foo'], []]
"  :echo Filtered(function('len'), mylist)
function! Filtered(fn, l)
  let new_list = deepcopy(a:l)
  call filter(new_list, string(a:fn) . '(v:val)')
  return new_list
endfunction

" example"
"  :let mylist = [[1, 2], [], ['foo'], []]
"  :echo Removed(function('len'), mylist)
function! Removed(fn, l)
  let new_list = deepcopy(a:l)
  call filter(new_list, '!' . string(a:fn) . '(v:val)')
  return new_list
endfunction

