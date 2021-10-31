Class {
	#name : #GtTargetCircleWithUnderlineAdornment,
	#superclass : #GtYellowCircleExplanationTextAdornment,
	#instVars : [
		'start',
		'stop',
		'coder',
		'node'
	],
	#category : 'GToolkit-Explainer-Coder add-on'
}

{ #category : #accessing }
GtTargetCircleWithUnderlineAdornment >> coder: aCoder [
	coder := aCoder.
]

{ #category : #accessing }
GtTargetCircleWithUnderlineAdornment >> doAffect: aTBrTextEditorTextualPiece in: anEditorElement [
	| circleElement underlineRules |
	
	circleElement := super doAffect: aTBrTextEditorTextualPiece in: anEditorElement.

	circleElement addEventHandlerOn: GtExplanationLinkConnectedEvent
		do: [ :anEvent |
			"underlineRules := GtCompositeHighlighter forHighlighters: { self stylerRule }.
			coder highlighter: underlineRules" ].

	circleElement addEventHandlerOn: GtExplanationLinkDisconnectedEvent 
		do: [ :anEvent |
			anEvent consumed: true.
			"coder removeAttributeNamed: #highlighter.
			coder requestUpdateAddOns.
			coder requestStyleSourceText" ].

	^ circleElement
]

{ #category : #initialization }
GtTargetCircleWithUnderlineAdornment >> initialize [
	super initialize.

	start := stop := 1
]

{ #category : #accessing }
GtTargetCircleWithUnderlineAdornment >> node: aNode [
	node := aNode.
]

{ #category : #accessing }
GtTargetCircleWithUnderlineAdornment >> start: aStartPoint [
	start := aStartPoint.
]

{ #category : #accessing }
GtTargetCircleWithUnderlineAdornment >> stop: aStopPoint [
	stop := aStopPoint.
]

{ #category : #'as yet unclassified' }
GtTargetCircleWithUnderlineAdornment >> stylerRule [
	^ (node isKindOf: RBMessageNode)
		ifTrue: [ GtPharoAstNodeHighlighterStylerRule new
				nodeClassName: node className asSymbol;
				styleBlock: [ :aNode :aText | 
					node keywordsIntervals
						do: [ :each | 
							(aText from: each first to: each last)
								attributes:
									{(BlTextHighlightAttribute new
										paint: BrGlamorousColors textHighlightColor)} ].
					(aText
						from: node keywordsIntervals first first
						to: node keywordsIntervals last last)
						attributes:
							{(BlTextUnderlineAttribute new
								color: BrGlamorousColors textHighlightColor)} ] ]
		ifFalse: [ GtPharoAstNodeHighlighterStylerRule new
				nodeClassName: node className asSymbol;
				styleBlock: [ :aNode :aText | 
					(aText from: start to: stop)
						attributes:
							{(BlTextHighlightAttribute new
								paint: BrGlamorousColors textHighlightColor)} ] ]
]
