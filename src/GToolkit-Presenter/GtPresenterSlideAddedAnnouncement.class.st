Class {
	#name : #GtPresenterSlideAddedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'slide'
	],
	#category : #'GToolkit-Presenter-Models - Events'
}

{ #category : #generated }
GtPresenterSlideAddedAnnouncement >> slide [
	<objectGetter: #slide>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ slide
]

{ #category : #generated }
GtPresenterSlideAddedAnnouncement >> slide: aSlide [
	<objectSetter: #slide>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	slide := aSlide
]
