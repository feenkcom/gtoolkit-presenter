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

{ #category : #accessing }
GtPlaygroundLiveSlide >> codeFromMethod: aMethod [
	| notTemp |
	notTemp := aMethod ast body children detect: [:aNode | aNode isTemp not ].

	^ String streamContents: [ :stream |
		aMethod ast comments ifNotEmpty: [
			stream
				nextPutAll: '"';
				nextPutAll: aMethod ast comments first contents;
				nextPutAll: '"';
				nextPutAll: String cr].
			
		(aMethod sourceCode 
			copyFrom: notTemp start to: aMethod ast stop) lines 
				do: [ :aLine |
					stream nextPutAll: (aLine removePrefix: String tab) ]
				separatedBy: [ stream cr ] ]
]

{ #category : #'api - instantiation' }
GtPlaygroundLiveSlide >> create [
	"Horrible (hopefully temporary) workaround"
	| page pageTool toolElement |

	^ Smalltalk globals 
		at: #LePage  
		ifPresent: [:lePage | 
			page := LePage new.
			playbook pages first snippets do: [:s |
				page addSnippet: (LePharoSnippet code: s sourceCode)].
			pageTool := page asLepiterPagePhlowTool.
			toolElement := pageTool asElementDo: [ :e | e ].
			GtPager createWrappedOn: toolElement ]
		ifAbsent: [ GtPlayground createOn: playbook ]
]

{ #category : #initialization }
GtPlaygroundLiveSlide >> initialize [
	super initialize.
	playbook := GtPlayBook new
		addPlayPage: GtPlayPage new; 
		subscribeExternalTools.
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
	aScripter wait forEmptySpaceTaskQueue.
	aScripter
		substep: 'Evaluate and inspect snippet'
		do: [ :aStep | 
			aStep click
				label: 'Click on evaluate and inspect button';
				onBreadthFirstChildOfClass: GtPlayground;
				onChildNamed: #content;
				onBreadthFirstChildOfClass: GtPageSnippetsElement;
				onChildAt: aPosition;
				id: GtSourceCoderDoItAndGoActionId.
			aStep wait forEmptySpaceTaskQueue ].
	aScripter syncContinue.
	^ aScripter elementWithoutParent
]

{ #category : #accessing }
GtPlaygroundLiveSlide >> newSnippet: el [
	playbook pages first addSnippet: GtCoderSnippet new.
	^ playbook pages last snippets last sourceCode: el
]

{ #category : #accessing }
GtPlaygroundLiveSlide >> newSnippetFromMethod: aMethod [
	self newSnippet: ((self codeFromMethod: aMethod))
]

{ #category : #accessing }
GtPlaygroundLiveSlide >> playbook: aBlock [
	playbook := aBlock
]

{ #category : #accessing }
GtPlaygroundLiveSlide >> snippets: aCollection [
	playbook := GtPlayBook newWithCodeSnippetContent: aCollection first.
	aCollection allButFirst do: [ :el | self newSnippet: el ]
]
