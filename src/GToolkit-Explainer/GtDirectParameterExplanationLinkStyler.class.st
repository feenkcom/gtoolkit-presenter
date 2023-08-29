Class {
	#name : #GtDirectParameterExplanationLinkStyler,
	#superclass : #GtSourceExplanationLinkStyler,
	#instVars : [
		'selectorsDictionary',
		'parameterName',
		'parameterIdentifier'
	],
	#category : #'GToolkit-Explainer-Coder add-on'
}

{ #category : #visiting }
GtDirectParameterExplanationLinkStyler >> highlightNode: aNode [ 
	| anAttribute |

	anAttribute := GtYellowCircleExplanationTextAdornment
		forIdentifier: parameterIdentifier .

	self
		attribute: anAttribute
		from: aNode startPosition - 1
		to: aNode startPosition - 1
]

{ #category : #initialization }
GtDirectParameterExplanationLinkStyler >> initialize [
	super initialize.

	selectorsDictionary := Dictionary new
]

{ #category : #adding }
GtDirectParameterExplanationLinkStyler >> parameterName: aName withIdentifier: aParameterIdentifier [
	parameterName := aName.
	parameterIdentifier := aParameterIdentifier
]

{ #category : #visiting }
GtDirectParameterExplanationLinkStyler >> visitReturn: aReturn [
	super visitReturn: aReturn.
	
	(aReturn value isVariable and: [ 
		aReturn value variableName = parameterName ])
			ifTrue: [ 
				self highlightNode: aReturn ]
]
