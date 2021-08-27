Class {
	#name : 'GtAnyModelSlide',
	#superclass : 'GtSlide',
	#category : 'GToolkit-Presenter'
}

{ #category : 'api - instantiation' }
GtAnyModelSlide >> create [
	| book |
	book := GtPlayBook newWithCodeSnippetContent: 'MooseModel root allModels first'.
	^ GtPlayground createOn: book
]
