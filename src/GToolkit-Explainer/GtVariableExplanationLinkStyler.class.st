"
I add a yellow circle adornment to variables in a text. The variables are argument node, temporary nodes, self nodes, super node and global nodes.
"
Class {
	#name : #GtVariableExplanationLinkStyler,
	#superclass : #GtSourceExplanationLinkStyler,
	#instVars : [
		'variablesDictionary',
		'coder'
	],
	#category : #'GToolkit-Explainer-Coder add-on'
}

{ #category : #adding }
GtVariableExplanationLinkStyler >> addVariableName: aVariableName [
	self addVariableName: aVariableName withIdentifier: aVariableName.
]

{ #category : #adding }
GtVariableExplanationLinkStyler >> addVariableName: aVariableName withIdentifier: anIdentifier [
	variablesDictionary at: aVariableName put: anIdentifier.
]

{ #category : #adding }
GtVariableExplanationLinkStyler >> addVariables: aCollection [
	aCollection do: [ :variable | self addVariableName: variable ].
]

{ #category : #accessing }
GtVariableExplanationLinkStyler >> coder: aMethodCoder [
	coder := aMethodCoder.
]

{ #category : #initialization }
GtVariableExplanationLinkStyler >> initialize [
	super initialize.
	variablesDictionary := IdentityDictionary new.
	coder := GtPharoMethodCoder new.
]

{ #category : #asserting }
GtVariableExplanationLinkStyler >> shouldAddUnderline [
	^ coder compiledMethod isNotNil.
]

{ #category : #accessing }
GtVariableExplanationLinkStyler >> variablesAssociations [
	^ variablesDictionary associations.
]

{ #category : #visiting }
GtVariableExplanationLinkStyler >> visitVariableNode: aVariableNode [
	super visitVariableNode: aVariableNode.
	self variablesAssociations do: [:association |
		(aVariableNode name asString = association key) ifTrue: [ 
			self 
				styleFrom: (aVariableNode start - 1) 
				to: (aVariableNode start - 1) 
				with: ((self shouldAddUnderline)
					ifTrue: [ {GtTargetCircleWithUnderlineAdornment new
						identifier: (association value);
						coder: coder;
						node: aVariableNode;
						start: aVariableNode start;
						stop: (aVariableNode start + aVariableNode name byteSize - 1)} ]
					ifFalse: [ {GtYellowCircleExplanationTextAdornment 
						forIdentifier: (association value)} ]) ]].
]
