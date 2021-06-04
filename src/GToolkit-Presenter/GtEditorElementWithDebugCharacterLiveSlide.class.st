"
I show an editor element where each character is displayed alongside its position.

{{gtMethod:GtExampleLiveShow>>#editorElementWithDebugCharacterExampleSlideFor:|expanded=}}


"
Class {
	#name : #GtEditorElementWithDebugCharacterLiveSlide,
	#superclass : #GtEditorElementLiveSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtEditorElementWithDebugCharacterLiveSlide >> create [
	<return: #Object>
	| aText |
	
	aText := 'Each character', String cr, 'in The Moldable Editor', String cr,
		'can be rendered as a', String cr, 'separate visual element', String cr,
		'which enables high level', String cr, 'of customisation'.
	
	^ (BrTextEditorOperatorExamples new editorFor: aText) asScalableElement
]
