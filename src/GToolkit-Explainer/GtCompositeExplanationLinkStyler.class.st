"
I have a collection of stylers to apply yellow circles adornments in a code.


"
Class {
	#name : #GtCompositeExplanationLinkStyler,
	#superclass : #GtSourceExplanationLinkStyler,
	#instVars : [
		'links'
	],
	#category : 'GToolkit-Explainer-Coder add-on'
}

{ #category : #'as yet unclassified' }
GtCompositeExplanationLinkStyler class >> forLinks: aCollection [
	^ self new
		forLinks: aCollection;
		yourself
]

{ #category : #initialization }
GtCompositeExplanationLinkStyler >> forLinks: aCollection [
	links := aCollection
]

{ #category : #accessing }
GtCompositeExplanationLinkStyler >> links [
	^ links
]

{ #category : #styling }
GtCompositeExplanationLinkStyler >> style: aText ast: ast [
	self links do: [ :each | each style: aText ast: ast ]
]

{ #category : #accessing }
GtCompositeExplanationLinkStyler >> stylers [
	^ self links
]
