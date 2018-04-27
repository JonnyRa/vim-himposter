# vim-himposter
tools for manipulating imports in haskell

##adding imports
The most useful one is `HimposterAddImportForIdentifierUnderCursor`.

*This assumes you have tags working* it won't work if you don't!

It automates the process of adding an import when you know the right type or function name - you can just type the code
and then trigger the call and it:

* goes to the relevant file (based on the tag)
* works out the right namespace for the file (based on path)
* swaps back to the original file
* goes to the imports 
* adds an unqualified import for the other file
* returns the view to the original state

It doesn't do anything clever if you already have the file imported - it won't add to specific import lists. 
If the identifier doesn't have a tag (eg if it's from a third-party package) then it won't work and you'll have to do it yourself.

##Setting up mappings
to enable default mappings set the following variable:

`g:himporterCreateMappings = 1`

this sets the following mappings :

```vim
"mapping mnemonics in comments:
"import generate
nnoremap <leader>ig :call HimposterMakeImportForCurrentFile()<cr>
"import insert
nnoremap <leader>ii :call HimposterInsertImport<cr>
"add import 
nnoremap <leader>ai :call HimposterAddImportForIdentifierUnderCursor()<cr>
"goto imports
nnoremap <Leader>gi :call HimposterGoToImports()<cr>
```

##Waffle

effectively AddImportForIdentifierUnderCursor uses the other functions and is what you want most of the time

GoToImports is also really useful for editing/viewing/adding imports by hand

the others are mostly useful if AddImport imports the wrong file (it just uses the first tag matched) 
as you can use them manually to achieve the same thing easily:

if you manually find the right file you can do the following:

```
(when in the file you want to import)
MakeImport..
"swap to previous file
<C-^>
GoToImports
InsertImport
go back a few times to get to where you were before
```

