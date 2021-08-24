Class {
	#name : 'GtValidatorAttributeEvent',
	#superclass : 'BlEvent',
	#instVars : [
		'hasAttribute'
	],
	#category : 'GToolkit-Explainer-Validator'
}

{ #category : 'accessing' }
GtValidatorAttributeEvent >> hasAttribute [
	^ hasAttribute ifNil: [ false ]
]

{ #category : 'accessing' }
GtValidatorAttributeEvent >> hasAttribute: aBoolean [
	hasAttribute := aBoolean
]
