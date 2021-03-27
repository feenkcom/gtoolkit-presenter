Class {
	#name : #GtExplainerExplanationAttributeAptitude,
	#superclass : #BrStyleCommonAptitude,
	#category : #'GToolkit-Explainer'
}

{ #category : #initialization }
GtExplainerExplanationAttributeAptitude >> initialize [
	super initialize.
	
	self
		default: [ :aStyle | aStyle background: (BrGlamorousColors textHighlightColor alpha: 0.5) ];
		hovered: [ :aStyle | aStyle background: (BrGlamorousColors textHighlightColor) ]
]
