Class {
	#name : #GtExplainerTargetAptitude,
	#superclass : #GtExplainerActorAptitude,
	#category : #'GToolkit-Explainer'
}

{ #category : #initialization }
GtExplainerTargetAptitude >> initialize [
	super initialize.
	
	self add: GtExplainerLinesAptitude new beForTarget.

	self default: [ :aStyle | 
		aStyle border: (BlBorder paint: (BrGlamorousColors textHighlightColor alpha: 0.7) width: 2).
		aStyle background: (BrGlamorousColors textHighlightColor alpha: 0.3) ]
]

{ #category : #'api - hooks' }
GtExplainerTargetAptitude >> onAttachedTo: anElement [
	super onAttachedTo: anElement.

	anElement explainer isTarget: true
]