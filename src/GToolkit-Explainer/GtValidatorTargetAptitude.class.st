Class {
	#name : #GtValidatorTargetAptitude,
	#superclass : #BrAptitude,
	#instVars : [
		'model'
	],
	#category : #'GToolkit-Explainer-Validator'
}

{ #category : #initialization }
GtValidatorTargetAptitude >> initializeListeners [
	super initializeListeners.
	self when: GtValidatorAttributeEvent do: [ :anEvent | self updateWidgetWithValue: anEvent hasAttribute ]
]

{ #category : #accessing }
GtValidatorTargetAptitude >> model [
	^ model
]

{ #category : #accessing }
GtValidatorTargetAptitude >> model: anObject [
	model := anObject
]

{ #category : #'api - hooks' }
GtValidatorTargetAptitude >> onInstalledIn: anElement [
	super onInstalledIn: anElement.
	(anElement explainer)
		model: model;
		isValidatorTarget: true
]

{ #category : #'api - hooks' }
GtValidatorTargetAptitude >> onUninstalledIn: anElement [
	(anElement explainer)
		model: nil;
		isValidatorTarget: false.
	super onUninstalledIn: anElement
]

{ #category : #private }
GtValidatorTargetAptitude >> updateWidgetWithValue: aBoolean [
]
