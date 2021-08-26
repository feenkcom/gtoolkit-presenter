Class {
	#name : 'GtSlideChanged',
	#superclass : 'Announcement',
	#instVars : [
		'slide'
	],
	#category : 'GToolkit-Presenter'
}

{ #category : 'accessing' }
GtSlideChanged >> slide [
	^ slide
]

{ #category : 'accessing' }
GtSlideChanged >> slide: aSlide [
	slide := aSlide
]
