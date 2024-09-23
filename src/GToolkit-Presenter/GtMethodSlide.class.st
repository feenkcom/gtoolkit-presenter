Class {
	#name : #GtMethodSlide,
	#superclass : #Object,
	#instVars : [
		'definingMethod'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'as yet unclassified' }
GtMethodSlide >> asElement [
	| aSlide |
	[ aSlide := thisContext
			object: definingMethod methodClass new
			perform: definingMethod selector
			withArguments: {GtEmptySlide new}
			inClass: definingMethod methodClass ]
		on: Error
		do: [ :anException | 
			aSlide := GtLiveSlideWithError new
					definingMethod: definingMethod;
					error: anException ].
	^ aSlide asElement
]

{ #category : #'as yet unclassified' }
GtMethodSlide >> definingMethod [
	^ definingMethod
]

{ #category : #accessing }
GtMethodSlide >> definingMethod: anObject [ 
	definingMethod := anObject.
	self subscribeToSystem
]

{ #category : #'as yet unclassified' }
GtMethodSlide >> gtDisplayOn: stream [
	stream nextPutAll: definingMethod gtDisplayString
]

{ #category : #'as yet unclassified' }
GtMethodSlide >> gtLiveFor: aView [
	<gtView>
	^ aView explicit
		title: 'Live';
		stencil: [ self asElement ]
]

{ #category : #'as yet unclassified' }
GtMethodSlide >> gtSourceFor: aView [
	<gtView>
	^ aView forward
		title: 'Source';
		object: [ definingMethod ];
		view: #gtSourceFor:
]

{ #category : #'as yet unclassified' }
GtMethodSlide >> subscribeToSystem [
	SystemAnnouncer uniqueInstance weak
]

{ #category : #'as yet unclassified' }
GtMethodSlide >> unsubscribeFromSystem [
	SystemAnnouncer uniqueInstance unsubscribe: self
]
