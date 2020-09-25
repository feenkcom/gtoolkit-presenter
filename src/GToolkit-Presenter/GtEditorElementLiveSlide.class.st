Class {
	#name : #GtEditorElementLiveSlide,
	#superclass : #GtLiveSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtEditorElementLiveSlide >> create [
	BlElement new.
]

{ #category : #accessing }
GtEditorElementLiveSlide >> withDebugCharacter [
	^ GtEditorElementWithDebugCharacterLiveSlide new.
]
