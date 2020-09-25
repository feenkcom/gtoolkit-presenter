Class {
	#name : #GtEditorElementLiveSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'slideType'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtEditorElementLiveSlide >> create [
	^ slideType.
]

{ #category : #accessing }
GtEditorElementLiveSlide >> withDebugCharacter [
	slideType := GtEditorElementWithDebugCharacterLiveSlide new.
]

{ #category : #accessing }
GtEditorElementLiveSlide >> withRotatedWords [
	slideType := GtEditorElementWithRotatedWordsLiveSlide new.
]

{ #category : #accessing }
GtEditorElementLiveSlide >> withTree [
	slideType := GtEditorElementWithTreeLiveSlide new.
]
