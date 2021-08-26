Class {
	#name : 'GtPlaygroundOnDictionarySlide',
	#superclass : 'GtSlide',
	#category : 'GToolkit-Presenter'
}

{ #category : 'api - instantiation' }
GtPlaygroundOnDictionarySlide >> create [
	| book |
	book := GtPlayBook newWithCodeSnippetContent: '{
	#number -> (21/2) . 
	#color -> Color cyan.
	#string -> ''A string is a basic data structure.
What could we possibly see different about it?''. 
	 } 
		asDictionary'.	
	^ GtPlayground createOn: book
]
