Class {
	#name : #GtPresenterSlideRemovedAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'slide'
	],
	#category : #'GToolkit-Presenter-Models - Events'
}

{ #category : #generated }
GtPresenterSlideRemovedAnnouncement >> slide [
	<objectGetter: #slide>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectGetterTemplate'>

	^ slide
]

{ #category : #generated }
GtPresenterSlideRemovedAnnouncement >> slide: aSlide [
	<objectSetter: #slide>
	<generatedFrom: #'GtRobocoderMetamodelAnnouncementTemplate>>#objectSetterTemplate'>

	slide := aSlide
]
