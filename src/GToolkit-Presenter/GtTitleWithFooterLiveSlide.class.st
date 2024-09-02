"
Superseded by GtTitleWithCenteredTextsSlide. Retain this only for compatibility.
"
Class {
	#name : #GtTitleWithFooterLiveSlide,
	#superclass : #GtTitleWithCenteredTextsSlide,
	#instVars : [
		'footer'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtTitleWithFooterLiveSlide >> footer: aString [
	self
		footerWithFormat: (aString asRopedText
				fontSize: 20;
				glamorousRegularFont)
]

{ #category : #accessing }
GtTitleWithFooterLiveSlide >> footerWithFormat: aText [
	self newTextWithFormat: aText
]
