Class {
	#name : #GtExplainerExplanationAptitude,
	#superclass : #GtExplainerActorAptitude,
	#category : #'GToolkit-Explainer'
}

{ #category : #initialization }
GtExplainerExplanationAptitude >> initialize [
	super initialize.
	
	self add: GtExplainerLinesAptitude new beForExplanation
]

{ #category : #'api - hooks' }
GtExplainerExplanationAptitude >> onAttachedTo: anElement [
	super onAttachedTo: anElement.

	anElement explainer isExplanation: true
]
