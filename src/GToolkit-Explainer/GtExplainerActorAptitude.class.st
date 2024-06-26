Class {
	#name : #GtExplainerActorAptitude,
	#superclass : #BrStyleCommonAptitude,
	#instVars : [
		'explanationModel'
	],
	#category : #'GToolkit-Explainer'
}

{ #category : #accessing }
GtExplainerActorAptitude >> explanationModel [
	^ explanationModel
]

{ #category : #accessing }
GtExplainerActorAptitude >> explanationModel: anObject [
	explanationModel := anObject.

	self widgetDo: [ :aWidget | aWidget explainer model: self explanationModel ]
]

{ #category : #'api - hooks' }
GtExplainerActorAptitude >> onAttachedTo: anElement [
	super onAttachedTo: anElement.

	anElement explainer model: self explanationModel
]
