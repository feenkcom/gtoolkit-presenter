Class {
	#name : #GtExampleSlideshow,
	#superclass : #GtLiveShow,
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtExampleSlideshow >> elementExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide element
		priority: 15;
		element: [BlElement new background: Color red].
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
