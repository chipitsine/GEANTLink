/*
    Copyright 2015-2016 Amebis
    Copyright 2016 GÉANT

    This file is part of GÉANTLink.

    GÉANTLink is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    GÉANTLink is distributed in the hope that it will be useful, but
    WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with GÉANTLink. If not, see <http://www.gnu.org/licenses/>.
*/

#include <StdAfx.h>


//////////////////////////////////////////////////////////////////////
// wxEAPBannerPanel
//////////////////////////////////////////////////////////////////////

wxEAPBannerPanel::wxEAPBannerPanel(wxWindow* parent) : wxEAPBannerPanelBase(parent)
{
    m_product_name->SetLabelText(wxT(PRODUCT_NAME_STR));
}


//////////////////////////////////////////////////////////////////////
// wxPasswordCredentials
//////////////////////////////////////////////////////////////////////

wxPasswordCredentials::wxPasswordCredentials(wxWindow* parent) : wxPasswordCredentialsBase(parent)
{
    // Load and set icon.
    if (m_shell32.load(_T("shell32.dll"), NULL, LOAD_LIBRARY_AS_DATAFILE | LOAD_LIBRARY_AS_IMAGE_RESOURCE)) {
        HICON icon;
        if (SUCCEEDED(LoadIconWithScaleDown(m_shell32, MAKEINTRESOURCE(269), GetSystemMetrics(SM_CXICON), GetSystemMetrics(SM_CYICON), &icon))) {
            m_icon.CreateFromHICON(icon);
            m_credentials_icon->SetIcon(m_icon);
            //Layout();
        }
    }
}
