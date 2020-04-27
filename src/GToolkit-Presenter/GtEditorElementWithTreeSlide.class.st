Class {
	#name : #GtEditorElementWithTreeSlide,
	#superclass : #GtSlide,
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtEditorElementWithTreeSlide >> create [
	| container verticalContainer horizontalContainer editorElement preview button label |
	
	preview := BlElement new
	constraintsDo: [ :c | 
		c vertical matchParent.
		c horizontal matchParent ].
	
	editorElement := GtWhatMakesBlocSpecialExplanation new editorOnSampleText
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal fitContent ];
		margin: (BlInsets all: 10);
		padding: (BlInsets all: 10);
		look: BrShadowLook;
		background: Color white.

	label := BrLabel new
			constraintsDo: [ :c | 
				c vertical fitContent.
				c horizontal fitContent ];
			look: BrGlamorousLabelLook;
			text:
				(('Press this button to see the element tree behind the editor') asRopedText
					glamorousRegularSmallSize;
					foreground: Color gray).
					
	button := BrButton new
		look: BrGlamorousButtonWithLabelLook;
		label: 'Show Tree';
		margin: (BlInsets all: 5);
		action: [ | m |
			preview removeChildren.
			m := GtMondrian new.
			editorElement paintEditorElementsWith: m.
			preview addChild: m asElement].						
	
	horizontalContainer := BlElement new
		layout: BlLinearLayout horizontal alignCenter;
		constraintsDo: [:c |
			c vertical fitContent.
			c horizontal fitContent].
	verticalContainer := BlElement new
		layout: BlLinearLayout vertical alignCenter;
		constraintsDo: [:c |
			c horizontal fitContent.
			c vertical fitContent].
	
	horizontalContainer
		addChild: label;
		addChild: button.
	verticalContainer
		addChild: editorElement;
		addChild: horizontalContainer.

	container := BlElement new
		constraintsDo: [ :c | 
			c vertical matchParent.
			c horizontal matchParent ];
		layout: BlLinearLayout vertical alignTopCenter.

	^ container
		addChild: verticalContainer;
		addChild: preview.
]
