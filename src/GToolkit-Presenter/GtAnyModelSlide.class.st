Class {
	#name : #GtAnyModelSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtAnyModelSlide >> create [
	| book |
	book := GtPlayBook newDefault.
	book pages first snippets first sourceCode: 'MooseModel root allModels first'.
	^ GtInspector createOnPlayBook: book
]
