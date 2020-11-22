"
I am a playground live slide. I receive a collection of snippets and display a playground with those snippets.

${method:GtExampleLiveShow>>#playgroundExampleSlideFor:|expanded=}$
"
Class {
	#name : #GtPlaygroundLiveSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'playbook'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtPlaygroundLiveSlide >> create [
	^ GtPlayground createOn: playbook
]

{ #category : #initialization }
GtPlaygroundLiveSlide >> initialize [
	super initialize.
	playbook := GtPlayBook newDefault.
]

{ #category : #accessing }
GtPlaygroundLiveSlide >> inspectSnippetAt: aPosition [
	| aScripter |
	
	aScripter := BlDevScripter new.
	aScripter
		substep: 'Playground Element'
		do: [ :aStep | 
			aStep set
				label: 'Playground';
				element: [ self asElement ] ].
	aScripter
		substep: 'Evaluate and inspect snippet'
		do: [ :aStep | 
			aStep click
				label: 'Click on evaluate and inspect button';
				onBreadthFirstChildOfClass: GtPlayground;
				onChildNamed: #content;
				onBreadthFirstChildOfClass: GtPageSnippetsElement;
				onChildAt: aPosition;
				onBreadthFirstChildOfClass: GtExpandableCoderElement;
				onBreadthFirstChildOfClass: GtCoderActionsElement;
				onBreadthFirstChildOfClass: BrToolbar;
				onChildAt: 2.
			aStep wait forEmptySpaceTaskQueue ].
	aScripter syncContinue.
	^ aScripter elementWithoutParent
]

{ #category : #accessing }
GtPlaygroundLiveSlide >> playbook: aBlock [
	playbook := aBlock
]

{ #category : #accessing }
GtPlaygroundLiveSlide >> snippets: aCollection [
	playbook := GtPlayBook newWithCodeSnippetContent: aCollection first.
	aCollection allButFirst do: [:el |
		playbook pages first addSnippet: GtCoderSnippet new.
		playbook pages last snippets last sourceCode: el]
]
