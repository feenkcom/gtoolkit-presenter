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
GtExampleSlideshow >> textAndElementExampleSlideFor: aSlide [
	<gtSlide>
	^ aSlide textAndElement
		priority: 5;
		newTextWithFormat: 'b' asRopedText;
		element: [GtTour new playgroundExplanationWithLinks];
		elementWeight: 0.6.
]

{ #category : #accessing }
GtExampleSlideshow >> textExampleFor: aSlide [
	<gtSlide>
	^ aSlide text
		priority: 10;
		newText: 'Something goes here' asRopedText.
]
