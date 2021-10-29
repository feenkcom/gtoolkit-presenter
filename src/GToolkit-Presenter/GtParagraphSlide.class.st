Class {
	#name : #GtParagraphSlide,
	#superclass : #GtSlide,
	#instVars : [
		'subtitle',
		'paragraph'
	],
	#category : 'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtParagraphSlide >> create [
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
							editor: (BrTextEditor new 
								text: self fullText))).

]

{ #category : #accessing }
GtParagraphSlide >> fullText [

	^'' asRopedText
		append: subtitle;
		append: String cr asRopedText;
		append: paragraph;
		yourself
]

{ #category : #initialization }
GtParagraphSlide >> initialize [ 

	super initialize.
	self subtitle: ''.
	self paragraph: ''.
]

{ #category : #accessing }
GtParagraphSlide >> paragraph: aString [

	paragraph := aString asRopedText fontSize: 30; glamorousRegularFont
]

{ #category : #accessing }
GtParagraphSlide >> subtitle: aString [

	subtitle := aString asRopedText fontSize: 40; glamorousRegularFont
]
