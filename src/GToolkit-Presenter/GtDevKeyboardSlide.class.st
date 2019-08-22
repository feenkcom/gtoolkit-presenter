Class {
	#name : #GtDevKeyboardSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtDevKeyboardSlide >> create [
	<return: #Object>

	^ BlDevKeyboard new asPannableElement
]
