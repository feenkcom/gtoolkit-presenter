"
I get an RBNode name and a styler rule. I style the node using the rule.


"
Class {
	#name : 'GtASTNodeStylerRule',
	#superclass : 'GtSourceExplanationLinkStyler',
	#instVars : [
		'styleBlock',
		'nodeClassName',
		'nodeClass'
	],
	#category : 'GToolkit-Explainer-Coder add-on'
}

{ #category : 'accessing' }
GtASTNodeStylerRule >> nodeClass [
	^ nodeClass ifNil: [ nodeClass := Smalltalk at: nodeClassName ifAbsent: [ self class ] ]
]

{ #category : 'accessing' }
GtASTNodeStylerRule >> nodeClassName [
	^ nodeClassName.
]

{ #category : 'accessing' }
GtASTNodeStylerRule >> nodeClassName: aNodeClassName [
	nodeClassName := aNodeClassName.
]

{ #category : 'asserting' }
GtASTNodeStylerRule >> shouldApplyToNode: aNode [
	^ aNode isKindOf: self nodeClass.
]

{ #category : 'accessing' }
GtASTNodeStylerRule >> styleBlock [
	^ styleBlock.
]

{ #category : 'accessing' }
GtASTNodeStylerRule >> styleBlock: aBlock [
	styleBlock := aBlock.
]

{ #category : 'visiting' }
GtASTNodeStylerRule >> visitNode: aNode [
	super visitNode: aNode.
	(self shouldApplyToNode: aNode)
		ifTrue: [ self styleBlock cull: aNode cull: text ].
]
