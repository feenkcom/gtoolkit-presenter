Class {
	#name : #GtExplainerExplanationAttributeAptitude,
	#superclass : #BrStyleCommonAptitude,
	#category : #'GToolkit-Explainer'
}

{ #category : #initialization }
GtExplainerExplanationAttributeAptitude >> initialize [
	super initialize.
	self
		default:
				[ :aStyle | aStyle background: (self theme button textHighlightColor alpha: 0.5) ];
		hovered:
				[ :aStyle | aStyle background: self theme button textHighlightColor ]
]
