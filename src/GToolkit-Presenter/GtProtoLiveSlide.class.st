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
	definingMethod := aCompiledMethod.
]

{ #category : #accessing }
GtProtoLiveSlide >> element [
	^ GtElementLiveSlide new
		definingMethod: (GtPhlowDefiningMethodsCollector new 
			stack: thisContext stack;
			collect).
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
