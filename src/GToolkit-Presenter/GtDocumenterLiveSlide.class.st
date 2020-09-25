Class {
	#name : #GtDocumenterLiveSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'document'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtDocumenterLiveSlide >> create [
	^ document createInPager maximized.
]

{ #category : #accessing }
GtDocumenterLiveSlide >> document [
	^ document.
]

{ #category : #accessing }
GtDocumenterLiveSlide >> document: aDocument [
	document := aDocument.
]

{ #category : #initialization }
GtDocumenterLiveSlide >> initialize [
	super initialize.
	document := GtDocument new.
]
