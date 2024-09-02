"
Superseded by GtTitleWithFootersLiveSlide. Retain this only for compatibility.
"
Class {
	#name : #GtTitleWithFooterLiveSlide,
	#superclass : #GtTitleWithFootersLiveSlide,
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
	self newFooterWithFormat: aText
]
