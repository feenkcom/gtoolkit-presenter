Class {
	#name : #GtHttpQuerySlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtHttpQuerySlide >> create [
	| book |
	book := GtPlayBook newWithCodeSnippetContent: 'url := ''https://blog.feenk.com'' asZnUrl 
		/ XdConstants cdnPathSegments
		/ XdConstants listFileName'.
	book pages first addSnippet: GtCoderSnippet new.
	book pages last snippets last sourceCode: 'ZnClient new
	url: url;
	get;
	response'.	
	^ GtPlayground createOn: book
]
