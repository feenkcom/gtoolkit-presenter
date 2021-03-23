Class {
	#name : #GtExplainerActorLook,
	#superclass : #BrStyleCommonLook,
	#instVars : [
		'explanationModel'
	],
	#category : #'GToolkit-Explainer'
}

{ #category : #accessing }
GtExplainerActorLook >> explanationModel [
	^ explanationModel
]

{ #category : #accessing }
GtExplainerActorLook >> explanationModel: anObject [
	explanationModel := anObject
]

{ #category : #'api - hooks' }
GtExplainerActorLook >> onAttachedTo: anElement [
	super onAttachedTo: anElement.

	anElement explainer model: self explanationModel
]
