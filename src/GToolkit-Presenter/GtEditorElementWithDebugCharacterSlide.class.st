Class {
	#name : #GtEditorElementWithDebugCharacterSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtEditorElementWithDebugCharacterSlide >> create [
	<return: #Object>
	| aText |
	
	aText := 'Each character', String cr, 'in The Moldable Editor', String cr,
		'can be rendered as a', String cr, 'separate visual element', String cr,
		'which enables high level', String cr, 'of customisation'.
	
	^ (BrTextEditorOperatorExamples new editorFor: aText) asScalableElement
]
