/*======================================================================*\
|| #################################################################### ||
|| # Project New Evolution Freeroam - NEFMOD Core          			  # ||
|| # ---------------------------------------------------------------- # ||
|| # Copyright (c)2011-2014 New Evolution Freeroam  				  # ||
|| # Created by Mellnik                                               # ||
|| # ---------------------------------------------------------------- # ||
|| # http://www.nefserver.net	    	                      		  # ||
|| #################################################################### ||
\*======================================================================*/

#pragma once

#ifndef _SINGLETON_H_
#define _SINGLETON_H_

#include <cstdlib>

template<class T>
class CSingleton
{
protected:
	static T *m_Instance;

public:
	virtual ~CSingleton() { }

	inline static T *Get()
	{
		if (m_Instance == NULL)
			m_Instance = new T;
		return m_Instance;
	}

	inline static void Destroy()
	{
		if (m_Instance != NULL)
		{
			delete m_Instance;
			m_Instance = NULL;
		}
	}
};

template <class T>
T* CSingleton<T>::m_Instance = NULL;

#endif // _SINGLETON_H_
