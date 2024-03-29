"
I am a paragraph live slide. I receive a paragraph subtitle and a text and display them on the screen.

{{gtMethod:GtExampleLiveShow>>#paragraphExampleSlideFor:|expanded=}}


"
Class {
	#name : #GtParagraphLiveSlide,
	#superclass : #GtLiveSlide,
	#instVars : [
		'subtitle',
		'paragraph'
	],
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtParagraphLiveSlide >> create [
	^  BlElement new 
			constraintsDo: [ :c |
				c horizontal matchParent.
				c vertical matchParent ];
			layout: BlLinearLayout horizontal;
				addChild: (
					BlElement new
						constraintsDo: [ :c |
							c horizontal matchParent.
							c vertical fitContent.
							c linear vertical alignCenter ];
						layout: BlLinearLayout vertical;
						addChild: (BrEditorElement new 
							size: 700@400;
							constraintsDo: [ :c |
								c linear horizontal alignCenter ];
							padding: (BlInsets all: 10);
							editor: (BrTextEditorModel new 
								text: self fullText))).

]

{ #category : #accessing }
GtParagraphLiveSlide >> fullText [
	^ '' asRopedText
		append: subtitle;
		append: String cr asRopedText;
		append: paragraph;
		yourself
]

{ #category : #initialization }
GtParagraphLiveSlide >> initialize [ 
	super initialize.
	self subtitle: ''.
	self paragraph: ''.
]

{ #category : #accessing }
GtParagraphLiveSlide >> paragraph: aString [
	self paragraphWithFormat: (aString asRopedText
			 fontSize: 30;
			 glamorousRegularFont)
]

{ #category : #accessing }
GtParagraphLiveSlide >> paragraphWithFormat: aText [
	paragraph := aText
]

{ #category : #accessing }
GtParagraphLiveSlide >> subtitle: aString [
	self subtitleWithFormat: (aString asRopedText
			 fontSize: 40;
			 glamorousRegularFont)
]

{ #category : #accessing }
GtParagraphLiveSlide >> subtitleWithFormat: aText [
	subtitle := aText
]
