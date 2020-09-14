Class {
	#name : #GtProtoLiveSlide,
	#superclass : #BrStencil,
	#instVars : [
		'priority'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtProtoLiveSlide >> element [
	^ GtElementLiveSlide new.
]

{ #category : #accessing }
GtProtoLiveSlide >> priority [
	^ priority.
]

{ #category : #accessing }
GtProtoLiveSlide >> priority: anInteger [
	priority := anInteger.
]

{ #category : #accessing }
GtProtoLiveSlide >> text [
	^ GtTextLiveSlide new.
]

{ #category : #accessing }
GtProtoLiveSlide >> textAndElement [
	^ GtTextAndElementLiveSlide new.
]
