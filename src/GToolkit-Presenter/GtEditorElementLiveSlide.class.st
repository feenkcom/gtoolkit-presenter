"
I am an editor element example live slide. I show different examples for the text editor. Take a look at my children for more examples on how to use me.


"
Class {
	#name : 'GtEditorElementLiveSlide',
	#superclass : 'GtLiveSlide',
	#instVars : [
		'slideType'
	],
	#category : 'GToolkit-Presenter'
}

{ #category : 'accessing' }
GtEditorElementLiveSlide >> create [
	^ slideType.
]

{ #category : 'accessing' }
GtEditorElementLiveSlide >> withDebugCharacter [
	slideType := GtEditorElementWithDebugCharacterLiveSlide new.
]

{ #category : 'accessing' }
GtEditorElementLiveSlide >> withRotatedWords [
	slideType := GtEditorElementWithRotatedWordsLiveSlide new.
]

{ #category : 'accessing' }
GtEditorElementLiveSlide >> withTree [
	slideType := GtEditorElementWithTreeLiveSlide new.
]
