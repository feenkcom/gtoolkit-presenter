"
I am an example live show. I have an example for each of the live slide templates.
"
Class {
	#name : #GtExampleLiveShow,
	#superclass : #Object,
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtExampleLiveShow >> allViewsExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide inspectorViews
		allViews;
		priority: 47.
]

{ #category : #accessing }
GtExampleLiveShow >> classCoderExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide classCoder
		priority: 41;
		class: GtABAddressBook;
		expandHeader: true;
		expandMethodAt: 2.
]

{ #category : #accessing }
GtExampleLiveShow >> connectorExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide connector
		priority: 42.
]

{ #category : #accessing }
GtExampleLiveShow >> customViewsExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide inspectorViews
		customViews;
		priority: 48.
]

{ #category : #accessing }
GtExampleLiveShow >> devKeyboardExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide devKeyboard
		priority: 43.
]

{ #category : #accessing }
GtExampleLiveShow >> documenterExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide documenter
		priority: 56;
		document: (GtDocumenter forClass: GtDocumenterExamples).
]

{ #category : #accessing }
GtExampleLiveShow >> editorElementWithDebugCharacterExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide editorElement
		withDebugCharacter;
		priority: 44.
]

{ #category : #accessing }
GtExampleLiveShow >> editorElementWithRotatedWordsExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide editorElement
		withRotatedWords;
		priority: 45.
]

{ #category : #accessing }
GtExampleLiveShow >> editorElementWithTreeExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide editorElement
		withTree;
		priority: 46.
]

{ #category : #accessing }
GtExampleLiveShow >> elementAndElementExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide elementAndElement
		priority: 35;
		newText: 'This is an element and element slide';
		leftElement: [BlElement new background: Color blue];
		rightElement: [BlElement new background: Color red].
]

{ #category : #accessing }
GtExampleLiveShow >> elementExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide element
		priority: 15;
		element: [BlElement new background: Color red].
]

{ #category : #accessing }
GtExampleLiveShow >> filePictureExampleSlideFor: aSlide [
	"<gtSlide>"
	^ aSlide filePicture
		priority: 54;
		fileReference: './pharo-local/iceberg/feenkcom/gtoolkit/doc/gtoolkit.png'.
]

{ #category : #accessing }
GtExampleLiveShow >> labelAndElementSlideFor: aSlide [
	<gtSlide>
	^ aSlide labelAndElement
		priority: 25;
		newFadedText: 'This is a label and element slide.';
		element: [BlElement new background: Color blue].
]

{ #category : #accessing }
GtExampleLiveShow >> liveElementTreeSlideExampleFor: aSlide [
	<gtSlide>
	| editor |
	editor := BrEditor new 
		look: BrGlamorousEditorLook;
		text: GtWhatMakesBlocSpecialExplanation new sampleText.
	^ aSlide liveElementTree
		priority: 51;
		targetElement: (BlUseAsyncFeatures disableDuring: [
			(editor gtViewsFor: GtPhlowView empty) asElementDo: [:e | 
				e 
					addEventFilterOn: BlMouseOverEvent 
					do: [ :anEvent | 
						anEvent target effect: (BlOverlayAboveEffect new paint: (BrGlamorousColors textHighlightColor alpha: 0.4)) ];
					addEventFilterOn: BlMouseOutEvent 
					do: [ :anEvent | anEvent target effect: (BlNullEffect new) ] ]]).
]

{ #category : #accessing }
GtExampleLiveShow >> mashExampleSlideFor: aSlide [
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
				addChild: ((GtPlaygroundLiveSlide new 
					snippets: {'BlElement new background: Color red.'};
					inspectSnippetAt: 1) asElement)).
]

{ #category : #accessing }
GtExampleLiveShow >> methodExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide example
		priority: 30;
		method: GtABAddressBookExample>>#myContactsAddressBook.
]

{ #category : #accessing }
GtExampleLiveShow >> multipleViewsForOneObjectExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide inspectorViews
		multipleViewsForOneObject;
		priority: 50.
]

{ #category : #accessing }
GtExampleLiveShow >> paragraphExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide paragraph
		priority: 55;
		paragraph: 'This is a paragraph slide';
		subtitle: 'Paragraph title'.
]

{ #category : #accessing }
GtExampleLiveShow >> playgroundExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide playground
		priority: 20;
		snippets: {'42 + 3'. '''This is a string'''}.
]

{ #category : #accessing }
GtExampleLiveShow >> rawViewsExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide inspectorViews
		rawViews;
		priority: 49.
]

{ #category : #accessing }
GtExampleLiveShow >> searchFiltersHierarchySlideFor: aSlide [
	<gtSlide>
	^ aSlide searchFiltersHierarchy
		priority: 57.
]

{ #category : #accessing }
GtExampleLiveShow >> slideshowExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide slideshow
		priority: 2;
		textWithFormat: 'Want to learn more about the Pharo syntax? Follow the show below' asRopedText glamorousRegularFont;
		slideshow: [ GtLiveShow openWithArrowsVisible: GtExampleLiveShow ] withTitle: 'Example Slideshow'.
]

{ #category : #accessing }
GtExampleLiveShow >> spotterExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide spotter
		priority: 52.
]

{ #category : #accessing }
GtExampleLiveShow >> textAndElementExampleFor: aSlide [
	<gtSlide>
	^ aSlide textAndElement
		priority: 5;
		newText: 'This is a text and element slide' asRopedText;
		element: [GtTour new playgroundExplanationWithLinks].
]

{ #category : #accessing }
GtExampleLiveShow >> textExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide text
		priority: 10;
		newText: 'This is a text slide'.
]

{ #category : #accessing }
GtExampleLiveShow >> titleExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide title
		priority: 1;
		titleWithFormat: ('Example Slideshow' asRopedText
			fontSize: 70;
			glamorousRegularFont).
]

{ #category : #accessing }
GtExampleLiveShow >> worldExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide world
		priority: 53.
]
