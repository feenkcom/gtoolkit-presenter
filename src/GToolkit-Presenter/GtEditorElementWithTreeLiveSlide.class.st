"
I show an editor element and a button that displays the tree for the respective editor element.

{{gtMethod:GtExampleLiveShow>>#editorElementWithTreeExampleSlideFor:|expanded=}}


"
Class {
	#name : #GtEditorElementWithTreeLiveSlide,
	#superclass : #GtEditorElementLiveSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #'api - instantiation' }
GtEditorElementWithTreeLiveSlide >> create [
	| container verticalContainer horizontalContainer editorElement preview button label |
	preview := BrVerticalPane new fitContent.

	editorElement := GtWhatMakesBlocSpecialExplanation new editorOnSampleText
			constraintsDo: [ :c | 
				c vertical fitContent.
				c horizontal fitContent ];
			margin: (BlInsets all: 10);
			padding: (BlInsets all: 10);
			aptitude: BrShadowAptitude;
			background: Color white.

	label := BrLabel new
			constraintsDo: [ :c | 
				c vertical fitContent.
				c horizontal fitContent ];
			text: ('Press this button to see the element tree behind the editor' asRopedText
					glamorousRegularSmallSize;
					foreground: Color gray).

	button := BrButton new
			aptitude: BrGlamorousButtonWithLabelAptitude;
			label: 'Show Tree';
			margin: (BlInsets all: 5);
			action: [ | m |
				preview removeChildren.
				m := GtMondrian new.
				editorElement paintEditorElementsWith: m.
				preview addChild: m asElement ].

	horizontalContainer := BrHorizontalPane new
			alignCenter;
			fitContent.
	verticalContainer := BrVerticalPane new
			alignCenter;
			fitContent.

	horizontalContainer
		addChild: label;
		addChild: button.
	verticalContainer
		addChild: editorElement;
		addChild: horizontalContainer.

	container := BrVerticalPane new
			fitContent;
			alignTopCenter.

	container
		addChild: verticalContainer;
		addChild: preview.
	^ container asScalableElement maxScale: 1.0
]
