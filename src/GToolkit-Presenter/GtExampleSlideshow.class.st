Class {
	#name : #GtExampleSlideshow,
	#superclass : #GtLiveShow,
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtExampleSlideshow >> allViewsExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide inspectorViews
		allViews;
		priority: 47.
]

{ #category : #accessing }
GtExampleSlideshow >> classCoderExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide classCoder
		priority: 41;
		class: GtABAddressBook;
		expandHeader: true;
		expandMethodAt: 2.
]

{ #category : #accessing }
GtExampleSlideshow >> connectorExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide connector
		priority: 42.
]

{ #category : #accessing }
GtExampleSlideshow >> customViewsExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide inspectorViews
		customViews;
		priority: 48.
]

{ #category : #accessing }
GtExampleSlideshow >> devKeyboardExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide devKeyboard
		priority: 43.
]

{ #category : #accessing }
GtExampleSlideshow >> editorElementWithDebugCharacterExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide editorElement
		withDebugCharacter;
		priority: 44.
]

{ #category : #accessing }
GtExampleSlideshow >> editorElementWithRotatedWordsExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide editorElement
		withRotatedWords;
		priority: 45.
]

{ #category : #accessing }
GtExampleSlideshow >> editorElementWithTreeExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide editorElement
		withTree;
		priority: 46.
]

{ #category : #accessing }
GtExampleSlideshow >> elementAndElementExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide elementAndElement
		priority: 35;
		newText: 'This is an element and element slide';
		leftElement: [BlElement new background: Color blue];
		rightElement: [BlElement new background: Color red].
]

{ #category : #accessing }
GtExampleSlideshow >> elementExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide element
		priority: 15;
		element: [BlElement new background: Color red].
]

{ #category : #accessing }
GtExampleSlideshow >> labelAndElementSlideFor: aSlide [
	<gtSlide>
	^ aSlide labelAndElement
		priority: 25;
		newFadedText: 'This is a label and element slide.';
		element: [BlElement new background: Color blue].
]

{ #category : #accessing }
GtExampleSlideshow >> mashExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide mash
		priority: 40;
		leftElement: 
			(BlElement new
				look: BrShadowLook;
				background: Color white;
				addChild: ((GtABCartoonAddressBookExample new cartoonAddressBook 
					gtViewsFor: GtPhlowView empty) asElement));
		centerElement: 
			(((GtMethodCoder 
					forMethod: GtABAddressBookExample>>#myContactsAddressBook) 
						expanded: true) asElement);
		rightElement: 
			(BlElement new
				look: BrShadowLook;
				background: Color white;
				addChild: ((GtPlaygroundSlide new 
					snippets: {'BlElement new background: Color red.'};
					inspectSnippetAt: 1) asElement)).
]

{ #category : #accessing }
GtExampleSlideshow >> methodExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide example
		priority: 30;
		method: GtABAddressBookExample>>#myContactsAddressBook.
]

{ #category : #accessing }
GtExampleSlideshow >> multipleViewsForOneObjectExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide inspectorViews
		multipleViewsForOneObject;
		priority: 50.
]

{ #category : #accessing }
GtExampleSlideshow >> playgroundExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide playground
		priority: 20;
		snippets: {'42 + 3'. '''This is a string'''}.
]

{ #category : #accessing }
GtExampleSlideshow >> rawViewsExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide inspectorViews
		rawViews;
		priority: 49.
]

{ #category : #accessing }
GtExampleSlideshow >> slideshowExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide slideshow
		priority: 2;
		textWithFormat: 'Want to learn more about the Pharo syntax? Follow the show below' asRopedText glamorousRegularFont;
		slideshow: [ GtExampleSlideshow new create] withTitle: 'Example Slideshow'.
]

{ #category : #accessing }
GtExampleSlideshow >> textAndElementExampleFor: aSlide [
	<gtSlide>
	^ aSlide textAndElement
		priority: 5;
		newText: 'This is a text and element slide' asRopedText;
		element: [GtTour new playgroundExplanationWithLinks].
]

{ #category : #accessing }
GtExampleSlideshow >> textExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide text
		priority: 10;
		newText: 'This is a text slide'.
]

{ #category : #accessing }
GtExampleSlideshow >> titleExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide title
		priority: 1;
		titleWithFormat: ('Example Slideshow' asRopedText
			fontSize: 70;
			glamorousRegularFont).
]
