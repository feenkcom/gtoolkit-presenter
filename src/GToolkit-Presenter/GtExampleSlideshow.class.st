Class {
	#name : #GtExampleSlideshow,
	#superclass : #GtLiveShow,
	#category : #'GToolkit-Presenter'
}

{ #category : #accessing }
GtExampleSlideshow >> elementExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide element
		priority: 20;
		element: [BlElement new background: Color red].
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
