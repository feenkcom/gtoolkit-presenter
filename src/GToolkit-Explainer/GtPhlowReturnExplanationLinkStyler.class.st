Class {
	#name : #GtPhlowReturnExplanationLinkStyler,
	#superclass : #GtSourceExplanationLinkStyler,
	#instVars : [
		'selectorsDictionary',
		'parameterName',
		'returnIdentifier'
	],
	#category : #'GToolkit-Explainer-Coder add-on'
}

{ #category : #visiting }
GtPhlowReturnExplanationLinkStyler >> highlightNode: aNode [ 
	| anAttribute |

	anAttribute := GtYellowCircleExplanationTextAdornment
		forIdentifier: returnIdentifier .

	self
		attribute: anAttribute
		from: aNode startPosition - 1
		to: aNode startPosition - 1
]

{ #category : #initialization }
GtPhlowReturnExplanationLinkStyler >> initialize [
	super initialize.

	returnIdentifier := #ReturnNode
]

{ #category : #accessing }
GtPhlowReturnExplanationLinkStyler >> returnIdentifier [
	^ returnIdentifier
]

{ #category : #accessing }
GtPhlowReturnExplanationLinkStyler >> returnIdentifier: anObject [
	returnIdentifier := anObject
]

{ #category : #visiting }
GtPhlowReturnExplanationLinkStyler >> visitReturn: aReturn [
	super visitReturn: aReturn.
	
	self highlightNode: aReturn
]
