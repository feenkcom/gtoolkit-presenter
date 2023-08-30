Class {
	#name : #GtPhlowDirectParameterExplanationLinkStyler,
	#superclass : #GtSourceExplanationLinkStyler,
	#instVars : [
		'selectorsDictionary',
		'parameterName',
		'parameterIdentifier'
	],
	#category : #'GToolkit-Explainer-Coder add-on'
}

{ #category : #visiting }
GtPhlowDirectParameterExplanationLinkStyler >> highlightNode: aNode [ 
	| anAttribute |

	anAttribute := GtYellowCircleExplanationTextAdornment
		forIdentifier: parameterIdentifier .

	self
		attribute: anAttribute
		from: aNode startPosition - 1
		to: aNode startPosition - 1
]

{ #category : #initialization }
GtPhlowDirectParameterExplanationLinkStyler >> initialize [
	super initialize.

	selectorsDictionary := Dictionary new
]

{ #category : #adding }
GtPhlowDirectParameterExplanationLinkStyler >> parameterName: aName withIdentifier: aParameterIdentifier [
	parameterName := aName.
	parameterIdentifier := aParameterIdentifier
]

{ #category : #visiting }
GtPhlowDirectParameterExplanationLinkStyler >> visitNamedVariable: aNamedVariable [
	super visitNamedVariable: aNamedVariable.
	
	(aNamedVariable variableName = parameterName and: [ 
		aNamedVariable parent notNil and: [
			aNamedVariable parent isMethodPattern ] ])
		ifTrue: [ self highlightNode: aNamedVariable ]
]

{ #category : #visiting }
GtPhlowDirectParameterExplanationLinkStyler >> visitReturn: aReturn [
	super visitReturn: aReturn.
	
	(aReturn value isVariable and: [ 
		aReturn value variableName = parameterName ])
			ifTrue: [ 
				self highlightNode: aReturn ]
]
