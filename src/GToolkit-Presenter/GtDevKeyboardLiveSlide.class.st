"
I create a keyboard element.

{{gtMethod:GtExampleLiveShow>>#devKeyboardExampleSlideFor:|expanded}}


"
Class {
	#name : #GtDevKeyboardLiveSlide,
	#superclass : #GtLiveSlide,
	#category : 'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtDevKeyboardLiveSlide >> create [
	<return: #Object>
	^ BlDevKeyboard new asPannableElement
]
