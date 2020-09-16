Class {
	#name : #GtProtoLiveSlide,
	#superclass : #BrStencil,
	#instVars : [
		'priority',
		'definingMethod'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtProtoLiveSlide >> definingMethod [
	^ definingMethod.
]

{ #category : #accessing }
GtProtoLiveSlide >> definingMethod: aCompiledMethod [
	self unsubscribeFromSystem.
	definingMethod := aCompiledMethod.
	self subscribeToSystem.
]

{ #category : #accessing }
GtProtoLiveSlide >> element [
	^ GtElementLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #accessing }
GtProtoLiveSlide >> empty [
	^ GtEmptySlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #'private - event handling' }
GtProtoLiveSlide >> hasDefiningMethod [
	^ self definingMethod isNotNil
]

{ #category : #'private - event handling' }
GtProtoLiveSlide >> onDefiningMethodChange [
	"I am called when the defining method has changed.
	Subclasses may react to the method definition changes.
	I may be called from a non-UI process."
]

{ #category : #'private - event handling' }
GtProtoLiveSlide >> onMethodModified: aMethodModified [
	self hasDefiningMethod ifFalse: [ ^ self ].
	(self definingMethod gtPhlowIncludesCompiledMethod: aMethodModified methodAffected)
		ifFalse: [ ^ self ].
	self onDefiningMethodChange.
]

{ #category : #accessing }
GtProtoLiveSlide >> priority [
	^ priority.
]

{ #category : #accessing }
GtProtoLiveSlide >> priority: anInteger [
	priority := anInteger.
]

{ #category : #'private - subscriptions' }
GtProtoLiveSlide >> subscribeToSystem [
	SystemAnnouncer uniqueInstance weak
		when: MethodModified
		send: #onMethodModified:
		to: self
]

{ #category : #accessing }
GtProtoLiveSlide >> text [
	^ GtTextLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #accessing }
GtProtoLiveSlide >> textAndElement [
	^ GtTextAndElementLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
]

{ #category : #'private - subscriptions' }
GtProtoLiveSlide >> unsubscribeFromSystem [
	SystemAnnouncer uniqueInstance unsubscribe: self.
]
